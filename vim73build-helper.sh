#!/bin/sh
wget http://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2
tar xf vim-7.3.tar.bz2
mkdir vim73/patches
cd vim73/patches
wget ftp://ftp.vim.org/pub/vim/patches/7.3/7.3.*
cd ..
cat patches/7.3.* | patch -p0

