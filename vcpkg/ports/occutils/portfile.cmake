vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO paulbuechner/OCCUtils
  REF 0a8a5a103a25ad3f01527076b261ee98bde84406
  SHA512 d286bafa0e88d9a173771309f4b6dcae22d0abbb0fe51ffb6e1370054ddcba4a5366835a4f3abc4b1587011262e7aef633a700ca6d03265e059d6c2fd7d87e88
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
