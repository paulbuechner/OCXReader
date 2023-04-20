vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO paulbuechner/OCCUtils
  REF fa84c2586dd113c268b9dca11708dcac2b994696
  SHA512 7ed273062560798efd3226b194c5df9bf42414ca9c52306bda5b240f53a024ddb996beaaeeefa9c2b7195a9774b065556239538e5f29b599c334f3e30c2de2f9
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
