$n = 9

$matrix = Array.new($n)
for i in 0..$n-1
	$matrix[i] = Array.new($n)
end

$visit = Array.new
$prev = Array.new($n)
$dist = Array.new($n)

$visited = 0

for i in 0..$n-1
	for j in 0..$n-1
		if i == j
			$matrix[i][j] = 0
		else
			$matrix[i][j] = 9999
		end

	end
	
	$visit.push i
	$dist[i] = 9999
end
	
$dist[0] = 0


def pushNode(i,j,dist)
	$matrix[i][j] = dist
	$matrix[j][i] = dist
end

pushNode(0,2, 31)
pushNode(0,3, 36)

pushNode(1,4, 23)

pushNode(2,5, 50)
pushNode(2,3, 29)

pushNode(3,1, 45)
pushNode(3,2, 29)
pushNode(3,5, 11)
pushNode(3,4, 28)
pushNode(3,6, 72)

pushNode(4,8, 15)
pushNode(4,6, 17)

pushNode(5,6, 63)

pushNode(6,7, 56)

def dijikstra
	# 방문해야 할 곳이 남아있지 않을 때까지 반복
	while $visit.empty? == false
		min = 9999
		u = 0

		$visit.each do |j|
			if $dist[j] < min
				min = $dist[j] 
				u = j
			end
		end
		
		break if u == 9999

		$visit.delete u

		for j in 0..$n-1
			if u != j and $matrix[u][j] != 9999
				if $dist[j] > $dist[u] + $matrix[u][j]
					$dist[j] = $dist[u] + $matrix[u][j]
				end
			end
		end
	end	
end

dijikstra

p $dist