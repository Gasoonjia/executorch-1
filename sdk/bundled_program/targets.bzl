load("@fbsource//xplat/executorch/build:runtime_wrapper.bzl", "runtime")

def define_common_targets():
    """Defines targets that should be shared between fbcode and xplat.

    The directory containing this targets.bzl file should also contain both
    TARGETS and BUCK files that call this function.
    """

    for aten_mode in (True, False):
        aten_suffix = ("_aten" if aten_mode else "")
        runtime.cxx_library(
            name = "runtime" + aten_suffix,
            srcs = ["runtime.cpp"],
            exported_headers = ["runtime.h"],
            visibility = [
                "//executorch/...",
                "@EXECUTORCH_CLIENTS",
            ],
            deps = [
                "//executorch/runtime/core/exec_aten/util:dim_order_util" + aten_suffix,
                "//executorch/sdk/bundled_program/schema:bundled_program_schema_fbs",
            ],
            exported_deps = [
                "//executorch/runtime/core:memory_allocator",
                "//executorch/runtime/executor:program" + aten_suffix,
            ],
        )
