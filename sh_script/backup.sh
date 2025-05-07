#!/bin/bash

export BORG_REPO=/backup
# export BORG_PASSPHRASE=''

BACKUP_DEV=/dev/sda2
BACKUP_UUID="3109a4f0-0f51-4b60-af00-86fe49c3c29b"

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


mkdir -p $BORG_REPO
mount -v $BACKUP_DEV $BORG_REPO || exit 42
if ! test "$(find $BORG_REPO -maxdepth 1 | tail -n+2)"; then
    info "Init Borg repo"
    borg init --encryption=none $BORG_REPO
fi

borg break-lock $BORG_REPO # hacky

info "Starting linux backup"
borg create $BORG_OPTS               \
    --exclude '/home/*/.android/*'   \
    --exclude '/home/*/.bitmonero/*' \
    --exclude '/home/*/.babao.d/*'   \
    --exclude '/home/*/.cache/*'     \
    --exclude '/home/*/.ccache/*'    \
    --exclude '/home/*/.gem/*'       \
    --exclude '/home/*/.gradle/*'    \
    --exclude '/home/*/.local/*'     \
    --exclude '/home/*/.npm/*'       \
    --exclude '/home/*/.nv/*'        \
    --exclude '/home/*/.nuget/*'     \
    --exclude '/home/*/.roswell/*'   \
    --exclude '/home/*/.slime/*'     \
    --exclude '/home/*/.steam/*'     \
    --exclude '/home/*/.wine/*'      \
    --exclude '/home/*/Android/*'    \
    --exclude '/home/*/Downloads/*'  \
    --exclude '/home/*/Games/*'      \
    --exclude '/home/*/Music/*'      \
    --exclude '/home/*/Pictures/*'   \
    --exclude '/home/*/Shared/*'     \
    --exclude '/home/*/Videos/*'     \
    --exclude '/home/*/VirtualBox VMs/*' \
    --exclude '/root/.cache/*'       \
    --exclude '/root/.local/*'       \
    --exclude '/root/.wine/*'        \
    --exclude '/root/arch/out/*'     \
    --exclude '/root/arch/work/*'    \
    --exclude '/var/cache/*'         \
    --exclude '/var/tmp/*'           \
    --exclude '/var/log/*'           \
    --exclude '/var/lib/docker/*'    \
    --exclude '/var/lib/dhcpcd/*'    \
    --exclude '/var/lib/systemd/coredump/*' \
    ::'linux-{now}'                  \
    /etc                             \
    /home                            \
    /root                            \
    /var
backup_exit=$?

info "Pruning linux repository"
borg prune $PRUNE_OPTS --glob-archives 'linux-*'
prune_exit=$?


info "Compacting repository"
borg compact
compact_exit=$?

sync
umount -v $BORG_REPO

global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))
global_exit=$(( compact_exit > global_exit ? compact_exit : global_exit ))

if [ ${global_exit} -eq 0 ]; then
    info "Backup, Prune, and Compact finished successfully"
elif [ ${global_exit} -eq 1 ]; then
    info "Backup, Prune, and/or Compact finished with warnings"
else
    info "Backup, Prune, and/or Compact finished with errors"
fi

exit ${global_exit}
