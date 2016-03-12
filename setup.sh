#!/bin/bash
echo "安装将花费一定时间，请耐心等待直到安装完成^_^"
if which apt-get >/dev/null; then
	sudo apt-get install -y vim vim-gnome ctags python-setuptools python-dev git
elif which yum >/dev/null; then
	sudo yum install -y gcc vim git ctags python-setuptools python-devel	
fi

##Add HomeBrew support on  Mac OS
if which brew >/dev/null;then
    echo "You are using HomeBrew tool"
    brew install vim ctags git astyle
fi

cd ~/ && git clone https://github.com/angela0/myvim.git
mv -f ~/.vim ~/.vim_old
mv -f ~/.vimrc ~/.vimrc_old
cp myvim/default.vimrc ~/.vimrc

git clone https://github.com/VundleVim/Vundle.vim 
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/colors

cp -r Vundle.vim ~/.vim/bundle/
git clone https://github.com/vim-scripts/molokai 
cp -f molokai/colors/molokai.vim ~/.vim/colors/
rm -f ~/.vim/README

echo "正在努力为您安装vundle程序" > ma6174
echo "安装完毕将自动退出" >> ma6174
echo "请耐心等待" >> ma6174
vim ma6174 -c "PluginInstall" -c "q" -c "q"
rm -f ma6174
rm -rf myvim molokai Vundle.vim
echo "安装完成"
