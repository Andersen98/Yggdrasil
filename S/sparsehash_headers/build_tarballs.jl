# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "sparsehash_headers"
version = v"2.0.4"

# Collection of sources required to build this package
sources = [GitSource("https://github.com/sparsehash/sparsehash.git",
                   "1dffea3d917445d70d33d0c7492919fc4408fe5c")]

# Bash recipe for building across all platforms
script = raw"""
cd sparsehash*
install_license COPYING
./configure --prefix=${prefix}
make -j${nproc}
make install
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [AnyPlatform()]

# The products that we will ensure are always built
products = [ FileProduct("include/sparsehash/dense_hash_map", :dense_hash_map), FileProduct("include/sparsehash/dense_hash_set", :dense_hash_set), FileProduct("include/sparsehash/internal/densehashtable.h", :densehashtable_h), FileProduct("include/sparsehash/internal/hashtable-common.h",:hashtablecommon_h), FileProduct("include/sparsehash/internal/libc_allocator_with_realloc.h",:libc_allocator_with_realloc_h), FileProduct("include/sparsehash/internal/sparseconfig.h", :sparseconfig_h),FileProduct("include/sparsehash/internal/sparsehashtable.h",:sparsehashtable_h),FileProduct("include/sparsehash/sparse_hash_map",:sparse_hash_map),FileProduct("include/sparsehash/sparse_hash_set", :sparse_hash_set),FileProduct("include/sparsehash/sparsetable",:sparsetable), FileProduct("include/sparsehash/template_util.h" ,:template_util_h),FileProduct("include/sparsehash/type_traits.h", :type_traits_h)]

# Dependencies that must be installed before this package can be built
dependencies = Dependency[]

build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)
