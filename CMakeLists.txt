cmake_minimum_required(VERSION 3.0)
project(pram
	VERSION 5
	LANGUAGES NONE)

# Silence the warning about not having a compiler -- we are not using
# libdir anyway.
set(CMAKE_INSTALL_LIBDIR lib)
include(GNUInstallDirs)

install(
	FILES pram
	DESTINATION ${CMAKE_INSTALL_BINDIR})
install(
	FILES pram.1
	DESTINATION ${CMAKE_INSTALL_MANDIR}/man1)
