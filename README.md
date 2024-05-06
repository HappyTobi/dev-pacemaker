# Development Environment for Pacemaker

This project aims to provide a development environment setup for working on the Pacemaker project. It includes all the necessary tools and configurations to get started with Pacemaker azure development.

## Prerequisites

Before getting started, make sure you have the following software installed on your machine:

- [Git](https://git-scm.com/)
- [Docker](https://www.docker.com/)

## Getting Started

Clone project and start the devcontainer to start developing on Pacemaker azure-events or other python file.

## Debugging

Before starting debugging, you have to run the `start.sh` script at the src folder, to build and run the azure imds service mock / fake.

After starting the mock server, you can use the `Debug` options in the Visual Studio Code to debug the python file.
^
info: To debug the file, you have to modify the ocf.py file to add the following code:
```python
from:
if OCF_ACTION is None and len(argv) == 2:
to:
if OCF_ACTION is None and len(argv) == 3:
```

## Testing

To execute the unittest, you can use the `Run Test` option in the Visual Studio Code.


## Contributing

If you'd like to contribute to the Pacemaker project, please follow the [contribution guidelines](https://github.com/pacemaker/pacemaker/blob/main/CONTRIBUTING.md).

## License

This project is licensed under the [MIT License](https://github.com/pacemaker/pacemaker/blob/main/LICENSE).