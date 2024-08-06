prompt = 'Number of Finter : ';
x = input(prompt)
if isempty(x)
    txt = 'Nodata'; 
end
if x == 1
    detect_fingerprint_edges('Chard.jpg'); 
end
if x == 2
    detect_fingerprint_edges('Few.jpg'); 
end
if x == 3
    detect_fingerprint_edges('Kookkik.jpg'); 
end
if x == 4
    detect_fingerprint_edges('Pear.jpg'); 
end
if x == 5
    detect_fingerprint_edges('View.jpg'); 
end
if x == 6
    detect_fingerprint_edges('Aom.jpg');
end

%detect_fingerprint_edges('x');