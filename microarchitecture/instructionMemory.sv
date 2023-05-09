module instructionMemory
#(
    parameter int address_size = 14,
    parameter int data_width = 8
)
(
    input logic [address_size-1:0] addr,
    output logic [4*data_width-1:0] data
);

    logic [data_width-1:0] mem[0:2**address_size-1];

    initial begin
        $readmemh("instructionMemory.mem", mem);
    end

    assign data = {mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]};

endmodule 