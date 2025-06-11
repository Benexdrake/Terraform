cd VMs
./tf.sh destroy -auto-approve

cd ../Network
./tf.sh destroy -auto-approve

cd ../Main
./tf.sh destroy -auto-approve