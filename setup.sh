#!/bin/bash

cur=`pwd`

install_dep() {
    if which apt >/dev/null; then
        sudo apt install -y python-setuptools python3-dev git cmake astyle ctags build-essential libncurses5-dev bear
    elif which yum >/dev/null; then
        sudo yum install -y git ctags python-setuptools python-devel cmake
        # install astyle by youself
    fi

    ##Add HomeBrew support on  Mac OS
    if which brew >/dev/null;then
        echo "You are using HomeBrew tool"
        brew install vim ctags git astyle
    fi

    pip install autopep8
}

install_vim() {
    cd /tmp/

    git clone https://github.com/vim/vim
    cd vim
    ./configure --enable-multibyte --enable-python3interp --with-features=huge
    make -j $(lscpu  | grep "^CPU(s)" | awk '{print $2}')
    sudo make install
    rm -rf vim

    cd $cur
}

echo "安装将花费一定时间，请耐心等待直到安装完成^_^"
install_dep

mv -f ~/.vim ~/.vim_old
mv -f ~/.vimrc ~/.vimrc_old
ln -s $cur/default.vimrc ~/.vimrc

mkdir -p ~/.vim/{bundle,colors}
cd ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim

cd /tmp
rm molokai -rf && git clone https://github.com/vim-scripts/molokai
cp -f molokai/colors/molokai.vim ~/.vim/colors/ && rm -rf molokai
rm phd -rf && git clone https://github.com/vim-scripts/phd
cp -f phd/colors/phd.vim ~/.vim/colors/ && rm -rf phd

echo "正在努力为您安装vundle程序" > vim_install
echo "安装完毕将自动退出" >> vim_install
echo "请耐心等待" >> vim_install
vim vim_install -c "PluginInstall" -c "q" -c "q"
rm -f vim_install

cd ~/.vim/bundle/ultisnips
rm -f mysnippets && ln -s $cur/mysnippets .

echo "安装完成"
