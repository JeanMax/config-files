#!/bin/bash -xe

export BORG_REPO=/backup
# export BORG_PASSPHRASE=''

# borg init --encryption=none $BORG_REPO
borg break-lock $BORG_REPO # hacky

WIN_DEV=/dev/sda1
WIN_DIR=/tmp/mnt/win7

BACKUP_DEV=/dev/sdb3
BACKUP_DIR=/tmp/mnt/backup
BACKUP_UUID="7d969b47-855d-404e-869f-455acd9a5822"

# some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

BORG_OPTS="--verbose                       \
           --filter AME                    \
           --list                          \
           --stats                         \
           --show-rc                       \
           --compression zstd,12           \
           --exclude-caches"

PRUNE_OPTS="--list                          \
            --show-rc                       \
            --keep-daily    7               \
            --keep-weekly   4               \
            --keep-monthly  6"


info "Starting linux backup"
borg create $BORG_OPTS               \
    --exclude '/home/*/.cache/*'     \
    --exclude '/home/*/.ccache/*'    \
    --exclude '/home/*/.local/*'     \
    --exclude '/home/*/.bitmonero/*' \
    --exclude '/home/*/.wine/*'      \
    --exclude '/home/*/valx/*'       \
    --exclude '/home/*/Pictures/*'   \
    --exclude '/home/*/Videos/*'     \
    --exclude '/home/*/Music/*'      \
    --exclude '/home/*/Downloads/*'  \
    --exclude '/home/*/Desktop/*'    \
    --exclude '/home/*/Shared/*'     \
    --exclude '/root/.cache/*'       \
    --exclude '/root/.local/*'       \
    --exclude '/root/arch/out/*'     \
    --exclude '/root/arch/work/*'    \
    --exclude '/var/cache/*'         \
    --exclude '/var/tmp/*'           \
    --exclude '/var/log/*'           \
    --exclude '/var/lib/docker/*'    \
    --exclude '/var/lib/dhcpcd/*'    \
    ::'linux-{now}'                  \
    /etc                             \
    /home                            \
    /root                            \
    /var

info "Pruning linux repository"
borg prune $PRUNE_OPTS --prefix 'linux-'


if ! mount | grep -q $WIN_DEV; then
	info "Starting win backup"
	mkdir -pv $WIN_DIR
	mount -v $WIN_DEV $WIN_DIR

	borg create $BORG_OPTS                        \
		 --exclude $WIN_DIR/Users'/*/AppData/*'   \
		 --exclude $WIN_DIR/Users'/*/Downloads/*' \
		 ::'win-{now}'                            \
		 $WIN_DIR/Users

	umount -v $WIN_DIR
	rmdir -v $WIN_DIR

	info "Pruning win repository"
	borg prune $PRUNE_OPTS --prefix 'win-'
fi


if ! mount | grep -q $BACKUP_DEV \
		&& blkid | grep $BACKUP_DEV | grep -q $BACKUP_UUID; then
	info "Sync to backup device"
	mkdir -pv $BACKUP_DIR
	mount -v $BACKUP_DEV $BACKUP_DIR

	rsync -harv --delete $BORG_REPO/ $BACKUP_DIR/.

	sync
	umount -v $BACKUP_DIR
	rmdir -v $BACKUP_DIR
fi
