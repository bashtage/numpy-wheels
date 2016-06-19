# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    if [ -z "$IS_OSX" ]; then
        build_openblas
    fi
}

function run_tests {
    # Runs tests on installed distribution from an empty directory
    if [ -n "$IS_OSX" ]; then
        python -c 'import numpy; numpy.test("full")'
    else  # Test both architectures on OSX
        arch -i386 python -c 'import numpy; numpy.test("full")'
        arch -x86_64 python -c 'import numpy; numpy.test("full")'
    fi
    # Show BLAS / LAPACK used
    python -c 'import numpy; numpy.show_config()'
}
