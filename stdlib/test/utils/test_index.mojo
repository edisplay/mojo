# ===----------------------------------------------------------------------=== #
# Copyright (c) 2024, Modular Inc. All rights reserved.
#
# Licensed under the Apache License v2.0 with LLVM Exceptions:
# https://llvm.org/LICENSE.txt
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ===----------------------------------------------------------------------=== #
# RUN: %mojo -debug-level full %s

from testing import assert_equal

from utils import Index, StaticIntTuple


def test_basics():
    assert_equal(StaticIntTuple[2](1, 2), StaticIntTuple[2](1, 2))
    assert_equal(StaticIntTuple[3](1, 2, 3), StaticIntTuple[3](1, 2, 3))
    assert_equal(str(StaticIntTuple[3](1, 2, 3)), "(1, 2, 3)")
    assert_equal(StaticIntTuple[3](1, 2, 3)[2], 3)


def test_cast():
    assert_equal(
        str(StaticIntTuple[2](1, 2).cast[DType.int32]()),
        "(1, 2)",
    )
    assert_equal(
        str(StaticIntTuple[2, element_bitwidth=64](1, 2).cast[DType.int32]()),
        "(1, 2)",
    )
    assert_equal(
        str(StaticIntTuple[2, element_bitwidth=32](1, 2).cast[DType.int64]()),
        "(1, 2)",
    )
    assert_equal(
        str(
            StaticIntTuple[2, element_bitwidth=32](1, -2).cast[
                element_bitwidth=64
            ]()
        ),
        "(1, -2)",
    )
    assert_equal(
        str(
            StaticIntTuple[2, element_bitwidth=32](1, 2).cast[
                element_bitwidth=64, unsigned=True
            ]()
        ),
        "(1, 2)",
    )


def main():
    test_basics()
    test_cast()
