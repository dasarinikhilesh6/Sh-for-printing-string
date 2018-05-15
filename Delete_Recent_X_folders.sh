# Below command is to Delete all folders but the most recent X folders in shell
# Here X=10
cd "$Directory"
ls -t1 "$Directory" | tail -n $(echo $(ls -1 | wc -l) - 10 | bc) | xargs rm -rf