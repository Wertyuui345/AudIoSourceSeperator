# CAN ALSO THEORETICALLY USE $PMI_RANK, $SLURM_PROCID, $SLURM_NODEID TO REMOVE THE IF STATEMENTS, BUT RAN INTO ISSUES WHERE THOSE ENVIRONMENT VARIABLES WERE NOT POPULATING
MASTER_ADDR=$1 LOCAL_ADDR=$(hostname | cut -d '.' -f 1) #Master ADDR change based on argument passed in order.

echo first_local_addr_value @ $LOCAL_ADDR...
echo first master_addr_value @ $MASTER_ADDR...

if [ $MASTER_ADDR = $LOCAL_ADDR ]
then
    echo Launching master @ $MASTER_ADDR...
    RANK=0 python -m torch.distributed.launch --nproc_per_node=3 --nnodes=1 --master_addr=$MASTER_ADDR --node_rank=0 --master_port=3456 --use-env $SCRATCH/ls6/AudioSeperation/audiomodelmaskedgputest.py
else
    echo No matching addr...
fi
