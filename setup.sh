#!/bin/bash

cur=`pwd`

echo "安装将花费一定时间，请耐心等待直到安装完成^_^"
if which apt-get >/dev/null; then
    sudo apt-get install -y python-setuptools python-dev git cmake astyle ctags
elif which yum >/dev/null; then
    sudo yum install -y git ctags python-setuptools python-devel cmake astyle
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
ln -s `pwd`/default.vimrc /home/`whoami`/.vimrc

mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/colors

cd ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim

cd /tmp
rm molokai -rf && git clone https://github.com/vim-scripts/molokai
cp -f molokai/colors/molokai.vim ~/.vim/colors/
rm phd -rf && git clone https://github.com/vim-scripts/phd
cp -f phd/colors/phd.vim ~/.vim/colors/


echo "正在努力为您安装vundle程序" > install
echo "安装完毕将自动退出" >> install
echo "请耐心等待" >> install
vim install -c "PluginInstall" -c "q" -c "q"
rm -f install
cd ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/
ln -s $cur/.ycm_extra_conf.py .

cd ~/.vim/bundle/ultisnips
ln -s $cur/mysnippets .

echo "安装完成"
