clc;
clear;

%DEFINE INPUTS

%PARALLEL NETWORK
nodes = [1; 2];
edges = [1 2 2; 1 2 3];
port = [1 2];
resistance (nodes, edges, port);

%Series NETWORK
nodes = [1; 2; 3; 4];
edges = [1 2 1; 2 3 1; 3 4 1];
port = [1 4];
resistance (nodes, edges, port);

%TRIANGLE NETWORK
nodes = [1; 2; 3; 4; 5];
edges = [1 2 12; 2 3 8; 2 4 12; 3 5 8; 3 4 8; 4 5 8];
port = [1 5];
resistance (nodes, edges, port);

%LADDER NETWORK
nodes = [1; 2; 3; 4; 5; 6; 7; 8];
edges = [1 2 2; 2 3 2; 3 4 2; 4 5 2; 5 6 2; 6 7 2; 7 8 2; 2 7 2; 3 6 2];
port = [1 8];
resistance (nodes, edges, port);

nodes = [1; 2; 3; 4; 5; 6];
edges = [1 2 1; 2 3 1; 3 4 1; 4 5 1;5 1 1; 1 6 1; 2 6 1; 3 6 1; 4 6 1; 5 6 1];
port = [1 2];
resistance (nodes, edges, port);




%FUNCTION
function R = resistance(nodes, edges, port)

% Define the admittance matrix
n = max(nodes);
Y = zeros(n,n);
for i=1:size(edges,1)
    n1 = edges(i,1);
    n2 = edges(i,2);
    r = edges(i,3);
    if n1~=0
        Y(n1,n1) = Y(n1,n1) + 1/r;
    end
    if n2~=0
        Y(n2,n2) = Y(n2,n2) + 1/r;
    end
    if n1~=0 && n2~=0
        Y(n1,n2) = Y(n1,n2) - 1/r;
        Y(n2,n1) = Y(n2,n1) - 1/r;
    end

end

%Removing the row and column related to port2
 Y(port(2),:)=[];
 Y(:,port(2))=[];
 A = Y;
 disp(A);

% Define the result matrix R with a value of 1 in the row related to port1
R = zeros(size(A,1),1);
R(port(1),1) = 1;

% Solve for the unknown variables
X =  A\R;
answer = X(port(1));

% Display the solution with 2 decimals
disp('The equivalent resistance is:');
disp(round(answer , 2));
end


