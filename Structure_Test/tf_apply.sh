cd Main
./tf.sh apply -auto-approve

cd ../Network
./tf.sh apply -auto-approve

cd ../VMs
./tf.sh apply -auto-approve