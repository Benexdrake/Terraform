cd ./1.\ Main/
echo ">>>>> Creating Main Reasources..."
./tf.sh apply -auto-approve

cd ../2.\ Network/
echo ">>>>> Creating Network..."
./tf.sh apply -auto-approve

# cd ../3.\ SQL_Server_Public/
# echo ">>>>> Creating SQL Server..."
# ./tf.sh apply -auto-approve

cd ../4.\ Deploy/APIs
echo ">>>>> Creating Container and Deploy..."
./tf.sh apply -auto-approve

cd ../Dashboard
echo ">>>>> Creating Dashboard and Deploy..."
./tf.sh apply -auto-approve