#!/usr/bin/env python3
"""
Simple test script to verify Python functionality in PlatformIO Docker image
"""


def test_platformio_import():
    """Test that we can import PlatformIO modules"""
    try:
        import platformio

        print(f"✅ PlatformIO version: {platformio.__version__}")
        return True
    except ImportError as e:
        print(f"❌ Failed to import PlatformIO: {e}")
        return False


def main():
    """Main test function"""
    print("Testing Python environment for PlatformIO...")
    success = test_platformio_import()

    if success:
        print("✅ Python test completed successfully!")
    else:
        print("❌ Python test failed!")
        exit(1)


if __name__ == "__main__":
    main()
