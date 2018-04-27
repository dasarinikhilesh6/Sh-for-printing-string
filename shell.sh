!!How to print a string from a file and give that output as a input for another command
#!/bin/bash
servers="$(awk -F': ' '/line starting/{print $2}' /path/to/file)"
echo ip address= "${servers}"