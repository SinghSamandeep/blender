# ***** BEGIN GPL LICENSE BLOCK *****
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
#
# ***** END GPL LICENSE BLOCK *****

# commenting out, Ray will clean if needed.
# if(WIN32)
# 	set(OPENEXR_CMAKE_CXX_STANDARD_LIBRARIES "kernel32${LIBEXT} user32${LIBEXT} gdi32${LIBEXT} winspool${LIBEXT} shell32${LIBEXT} ole32${LIBEXT} oleaut32${LIBEXT} uuid${LIBEXT} comdlg32${LIBEXT} advapi32${LIBEXT} psapi${LIBEXT}")
# endif()

set(OPENEXR_PKG_CONFIG_PATH ${LIBDIR}/zlib/share/pkgconfig)
set(OPENEXR_EXTRA_ARGS
  --enable-static
  --disable-shared
  --enable-cxxstd=11
  --with-ilmbase-prefix=${LIBDIR}/ilmbase
  )

ExternalProject_Add(external_openexr
	URL ${OPENEXR_URI}
	DOWNLOAD_DIR ${DOWNLOAD_DIR}
	URL_HASH MD5=${OPENEXR_HASH}
	PREFIX ${BUILD_DIR}/openexr
	CONFIGURE_COMMAND ${CONFIGURE_ENV} && export PKG_CONFIG_PATH=${OPENEXR_PKG_CONFIG_PATH} && cd ${BUILD_DIR}/openexr/src/external_openexr/ && ${CONFIGURE_COMMAND} --prefix=${LIBDIR}/openexr ${OPENEXR_EXTRA_ARGS}
	BUILD_COMMAND ${CONFIGURE_ENV} && cd ${BUILD_DIR}/openexr/src/external_openexr/ && make -j${MAKE_THREADS}
	INSTALL_COMMAND ${CONFIGURE_ENV} && cd ${BUILD_DIR}/openexr/src/external_openexr/ && make install
	INSTALL_DIR ${LIBDIR}/openexr
)

add_dependencies(
	external_openexr
	external_zlib
	external_ilmbase
)
