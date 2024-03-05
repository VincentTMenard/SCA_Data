
function co = max_sequence(seq)

for i = 1:4, co{i}=[0]; end
co{seq(1)}(end) = co{seq(1)}(end) + 1; 
prev = seq(1);

for j = 2:numel(seq)
    if seq(j)==prev
        co{seq(j)}(end) = co{seq(j)}(end) + 1;
    else
        co{seq(j)} = [co{seq(j)} 1];
        prev = seq(j);
    end
end
for i = 1:4, co{i}=max(co{i}); end
end