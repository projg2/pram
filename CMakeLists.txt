cmake_minimum_required(VERSION 3.0)
project(pram
	VERSION 5
	LANGUAGES NONE)

# Silence the warning about not having a compiler -- we are not using
# libdir anyway.
set(CMAKE_INSTALL_LIBDIR lib)
include(GNUInstallDirs)

# Add tests.
enable_testing()
set(TESTS
	00basic
	01signoff-missing
	01signoff-present
	02bug-number
	02bug-url
	02closes-number
	02closes-url
	03bug-multiple
	03closes-multiple
	03combined-bug-closes
	03combined-signoff-bug
	04interactive-no
	04interactive-yes
	05editor-empty
	05editor-fail
	06gpgsign
	10threeway
	10threeway-disabled
)
foreach(t ${TESTS})
	add_test(
		NAME "${t}"
		COMMAND sh "${t}.sh"
		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/test)
	set_tests_properties("${t}"
		PROPERTIES
		SKIP_RETURN_CODE 77)
endforeach(t ${TESTS})

install(
	PROGRAMS pram
	DESTINATION ${CMAKE_INSTALL_BINDIR})
install(
	FILES pram.1
	DESTINATION ${CMAKE_INSTALL_MANDIR}/man1)
