#!/bin/bash

echo "安装将花费一定时间，请耐心等待直到安装完成^_^"
if which apt-get >/dev/null; then
    sudo apt-get install -y vim vim-gnome ctags python-setuptools python-dev git cmake
elif which yum >/dev/null; then
    sudo yum install -y gcc vim git ctags python-setuptools python-devel cmake
fi

##Add HomeBrew support on  Mac OS
if which brew >/dev/null;then
    echo "You are using HomeBrew tool"
    brew install vim ctags git astyle
fi

#cd ~/ && git clone https://github.com/angela0/myvim.git
mv -f ~/.vim ~/.vim_old
mv -f ~/.vimrc ~/.vimrc_old
#cp myvim/default.vimrc ~/.vimrc
ln -s `pwd`/myvim/default.vimrc /home/`whoami`/.vimrc

mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/colors

cd ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim

cd /tmp
git clone https://github.com/vim-scripts/molokai
cp -f molokai/colors/molokai.vim ~/.vim/colors/
git clone https://github.com/vim-scripts/phd
cp -f phd/colors/phd.vim~/.vim/colors/


echo "正在努力为您安装vundle程序" > install
echo "安装完毕将自动退出" >> install 
echo "请耐心等待" >> install
vim install -c "PluginInstall" -c "q" -c "q"
rm -f install
rm -rf myvim
#cd ~/bundle/YouCompleteMe/
#./install.py ---clang-completer
echo "安装完成"
