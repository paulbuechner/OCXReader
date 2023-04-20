vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO paulbuechner/OCCUtils
  REF 00f54be77c02d901c96c6ed82755e6737b29ba8d
  SHA512 05bce8105ae8cefb897ff82299b3373252d5ed21841073333acc30306af01925a1b0043b38b604b589bc67c9c4051599a59a61e7ee023e52088daa91462b32ea
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
