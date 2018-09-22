#!/bin/bash -x

# TODO: deps

function get_version() {
    pacman -Si "$1" | grep Version | sed 's/.*: \(.*\)-.*/\1/'
}

function install_tensorflow() {
    DIR=~/tf
    REPO=https://github.com/tensorflow/tensorflow
    BRANCH=r1.9

    WITH_CUDA=yep  # comment out to disable

    if ! test -e $DIR; then
        mkdir -pv $DIR
        cd $DIR
        git init
        git fetch $REPO $BRANCH:refs/remotes/origin/$BRANCH

        # git clone -b $BRANCH --single-branch https://github.com/tensorflow/tensorflow $DIR
        # cd $DIR
    else
        cd $DIR
        # git pull
    fi

    if test $WITH_CUDA; then
        CUDA_COMPUTE_CAPABILITIES="5.0"
        CUDA_VERSION=$(get_version cuda)
        CUDNN_VERSION=$(get_version cudnn)

        # https://stackoverflow.com/questions/43113508/math-functions-hpp-not-found-when-using-cuda-with-eigen
        # ln -sfv /usr/local/cuda/include/crt/math_functions.hpp /usr/local/cuda/include/math_functions.hpp

        # .tf_configure.bazelrc ?
        sed -i "s/CUDA', False/CUDA', True/" configure.py
        sed -i "s/CUDA_VERSION = .*/CUDA_VERSION = '$CUDA_VERSION'/" configure.py
        sed -i "s/CUDNN_VERSION = .*/CUDNN_VERSION = '$CUDNN_VERSION'/" configure.py
        sed -i "s/CUDA_COMPUTE_CAPABILITIES = .*/CUDA_COMPUTE_CAPABILITIES = '$CUDA_COMPUTE_CAPABILITIES'/" configure.py

        # CUDA_FLAG=--config=cuda
    fi
    sed -i 's/True,/False,/g' configure.py  # gcp/hdfs/s3 turned off

    bazel clean
    ./configure
    bazel build --config=opt $CUDA_FLAG //tensorflow/tools/pip_package:build_pip_package
    bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
    pip install --user /tmp/tensorflow_pkg/tensorflow-1.*.whl

    cd -
}

function install_bazel() {
    DIR=~/bazel
    ARCHIVE='https://github.com/bazelbuild/bazel/releases/download/0.9.0/bazel-0.9.0-dist.zip'

    WITH_LOW_MEMORY=yep  # (good for rasp!) comment out to disable


    if ! test -e $DIR; then
        wget $ARCHIVE
        unzip -d bazel bazel-*-dist.zip
        rm -v bazel-*-dist.zip
    fi
    cd $DIR

    if test $WITH_LOW_MEMORY; then
        sed -i 's/\(encoding UTF-8 ".*"$\)/\1 -J-Xmx500M/' scripts/bootstrap/compile.sh
    fi

    bash compile.sh
    sudo cp output/bazel /usr/local/bin/bazel

    cd -
}

function test_tensorflow() {
    python3 -c "import tensorflow as tf
hello = tf.constant('Hello, TensorFlow!')
sess = tf.Session()
print(sess.run(hello))"
}

function test_bazel() {
    bazel
}


if ! test_bazel; then
    set -e
    install_bazel
    test_bazel
    set +e
fi

if ! test_tensorflow; then
    set -e
    install_tensorflow
    test_tensorflow
    set +e
fi
