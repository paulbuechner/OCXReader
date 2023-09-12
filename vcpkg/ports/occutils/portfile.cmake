vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO paulbuechner/occutils
        REF 184cb6f960d1321b6f60dce69319cd5d0e22fdbf
        SHA512 f956ba6270b8e4fca7212c7a06e40344ce663eea5bd2564710b71a71ccc8831d6ef041aaf895ceeb64976ca23c76263e0d9e2c5a287c6ca9a13048bb38441108
        HEAD_REF main
)

vcpkg_configure_cmake(
        SOURCE_PATH ${SOURCE_PATH}
        PREFER_NINJA
        OPTIONS
        -DOCCUTILS_BUILD_TESTS=OFF
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/occutils)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

vcpkg_copy_pdbs()
vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/${PORT})

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
