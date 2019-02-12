
--打开支付宝
function openApp()
	r=0
	while r==0 do
		r = runApp("com.eg.android.AlipayGphone")
		--		toast("打开支付宝")
	end
end

--进入蚂蚁森林主页
function enterAntForestPage()
	while not findAntForestIcon() do
		findAntForestIcon()
	end
	keepScreen(true)
	x,y = findAntForestIcon()
	tap(x,y)
	keepScreen(false)
	i = 1
	while ( not findTreeLeaf() ) and i<3 do
		mSleep(5000)
		if findAntForestIcon() then
			keepScreen(true)
			x,y = findAntForestIcon()
			tap(x,y)
			keepScreen(false)
		end
		i = i+1
	end
end

--自定义模拟触摸屏幕函数
function tap(x, y)
	keepScreen(true)
	if x>-1 and y>-1 then
		touchDown(1, x, y);
		mSleep(50);
		touchUp(1, x, y);
	else
		toast("点击坐标不对")
	end
	keepScreen(false)
end

--moveDown函数: 从(x1,y1)移动到(x2,y2)
function moveDown(x1,y1,x2,y2)
	touchDown(1, x1, y1); --在 (x1, y1) 按下
	for i = 0,  y1-y2, y1-y2  do   --使用for循环连续滑动
		touchMove(1, x1, y1-i);
		mSleep(150);        --延迟
	end
	touchUp(1, x2, y2); --在 (x2, y2) 抬起
end

--moveUp函数: 从(x1,y1)移动到(x2,y2)
function moveUp(x1,y1,x2,y2)
	touchDown(1, x1, y1); --在 (x1, y1) 按下
	for i = 0,  y2-y1, y2-y1  do   --使用for循环连续滑动
		touchMove(1, x1, y1+i);
		mSleep(150);        --延迟
	end
	touchUp(1, x2, y2); --在 (x2, y2) 抬起
end

--自定义"xx的蚂蚁森林"主页遍历点击来实现能量采集的函数
function collect()
	for y=860, 460, -100 do
		for x=890, 185, -100 do
			touchDown(1,x,y)
			mSleep(50)
			touchUp(1,x,y)
		end
	end
end

--进入好友排行榜
function enterRank()
	while not findMoreFriends() do
		moveDown(520,1860,520,220)
	end
	keepScreen(true)
	x, y = findMoreFriends()
	tap(x,y)
	keepScreen(false)
	i = 1
	while not findGoldMedal() and i<3 do
		mSleep(2000)
		if findMoreFriends() then
			keepScreen(true)
			x, y = findMoreFriends()
			tap(x,y)
			keepScreen(false)
		end
		i = i+1
	end
end

--进入好友排行榜页面来回检测，若发现可收取或可代收的页面则点进去收取
function enterOthers()
	--当前屏幕中“手”和“心”都寻找完，并且还没有到达排行榜末尾时，向下滑动
	while not findNoMore() do
		--把当前屏幕中所有的“手”找到
		while findHand() do
			x,y = findHand()
			tap(x,y)
			
			t1 = timer()
			while (not findTreeLeaf() ) do
				findTreeLeaf()
				while ( (timer()-t1) > 10 ) do
					if ( (timer()-t1) >20 ) then
						break
					end
					collect()
				end
			end
			
--			while not findTreeLeaf() do
--				findTreeLeaf()
--			end
			collect()
			pressKey('BACK',false)
			while not findFriendsRank() do
				findFriendsRank()
			end
		end
		--当前屏幕中没有“手”之后，再找当前屏幕中所有的“心”
		while findHeart() do
			x,y = findHeart()
			tap(x,y)
			
			t1 = timer()
			while (not findTreeLeaf() ) do
				findTreeLeaf()
				while ( (timer()-t1) > 10 ) do
					if ( (timer()-t1) >20 ) then
						break
					end
					collect()
				end
			end
			
			
			
--			while not findTreeLeaf() do
--				findTreeLeaf()
--			end
			collect()
			pressKey('BACK',false)
			while not findFriendsRank() do
				findFriendsRank()
			end
		end
		moveDown(520,1860,520,220)
	end
	while findHand() do
		x,y = findHand()
		tap(x,y)
		
		t1 = timer()
			while (not findTreeLeaf() ) do
				findTreeLeaf()
				while ( (timer()-t1) > 10 ) do
					if ( (timer()-t1) >20 ) then
						break
					end
					collect()
				end
			end
		
--		while not findTreeLeaf() do
--			findTreeLeaf()
--		end
		collect()
		pressKey('BACK',false)
		while not findFriendsRank() do
			findFriendsRank()
		end
	end
		--当前屏幕中没有“手”之后，再找当前屏幕中所有的“心”
	while findHeart() do
		x,y = findHeart()
		tap(x,y)
		
		t1 = timer()
			while (not findTreeLeaf() ) do
				findTreeLeaf()
				while ( (timer()-t1) > 10 ) do
					if ( (timer()-t1) >20 ) then
						break
					end
					collect()
				end
			end
		
--		while not findTreeLeaf() do
--			findTreeLeaf()
--		end
		collect()
		pressKey('BACK',false)
		while not findFriendsRank() do
			findFriendsRank()
		end
	end
end

--通过多点找色函数找到蚂蚁森林页面树苗中树叶的颜色，用来确认是否已进入到蚂蚁森林个人页面
function findTreeLeaf()
	--晚上树叶的颜色
	x1, y1 = findMultiColorInRegionFuzzy(0x00c585,"11|-3|0x00c585,-1|-12|0x00c585", 100, 0, 0, 1079, 1919, 0, 0)
	--白天树叶的颜色
	x2, y2 = findMultiColorInRegionFuzzy(0x48af58,"22|9|0x48af58,-10|13|0x48af58,9|17|0x48af58", 95, 0, 0, 1079, 1919, 0, 0)
	if x1 > -1 or x2 > -1 then
		return true
	end
end

--通过多点找色函数找到支付宝首页的蚂蚁森林图标
function findAntForestIcon()
	x, y = findMultiColorInRegionFuzzy(0xffffff,"24|-5|0x29ab91,-27|1|0x35b097,-1|-17|0x4bb8a3,-24|-26|0x47b7a1,20|-27|0x29ab91,13|13|0xf9fdfc,-11|11|0x29ab91,1|39|0x2bab92", 95, 0, 0, 1079, 1919, 0, 0)
	if x > -1 then
		return x,y
	end
end

--通过多点找色函数找到蚂蚁森林主页末尾的“查看更多好友”中的“更多”二字
function findMoreFriends()
	x1, y1 = findMultiColorInRegionFuzzy(0x323232,"37|0|0x323232,20|26|0xeaeaea,5|27|0xbbbbbb,0|38|0x323232,38|38|0x323232,25|37|0x323232,29|30|0xfefefe,35|23|0x323232,19|15|0x323232", 100, 0, 0, 1079, 1919, 0, 0)
	x2, y2 = findMultiColorInRegionFuzzy(0x323232,"-15|12|0x323232,13|5|0x323232,-17|23|0x323232,9|17|0x616161,-11|30|0x323232,20|22|0x363636,-17|41|0x323232,14|39|0xfefefe,0|29|0x323232", 100, 0, 0, 1079, 1919, 0, 0)
	if x1 > -1 and x2 >-1 then
		return x1,y1
	end
end

--通过多点找色函数找到蚂蚁森林好友排行榜页面的“好友排行榜”中的“排行”二字
function findFriendsRank()
	x, y = findMultiColorInRegionFuzzy(0x262626,"10|-11|0x323232,2|36|0x111111,28|38|0x111111,47|2|0xffffff,47|22|0x111111,68|-7|0xffffff,66|37|0xffffff,101|10|0x111111,82|36|0x111111", 95, 0, 0, 1079, 1919, 0, 0)
	if x > -1 then
		return true
	end
end

--通过多点找色函数找到好友排行榜页面中的“手掌”标志，表示可以收取能量
function findHand()
	keepScreen(true)
	x, y = findMultiColorInRegionFuzzy(0xffffff,"-16|-25|0x1da06d,37|-22|0x1da06d,40|29|0x1da06d,25|16|0xfdfefe,0|-19|0xffffff", 100, 0, 0, 1079, 1919, 0, 0)
	if x > -1 then
		return x,y
	end
	keepScreen(false)
end

--通过多点找色函数找到好友排行榜页面中的“爱心”标志，表示可以帮好友收取能量
function findHeart()
	keepScreen(true)
	x, y = findMultiColorInRegionFuzzy(0xffffff,"-28|-24|0xf99137,29|-24|0xf99137,29|31|0xf99137,5|10|0xf99239,3|16|0xfffefd", 100, 0, 0, 1079, 1919, 0, 0)
	if x > -1 then
		return x,y
	end
	keepScreen(false)
end

--通过多点找色函数找到好友排行榜末尾的“没有”二字
function findNoMore()
	--	keepScreen(true)
	x1, y1 = findMultiColorInRegionFuzzy(0x333333,"5|4|0x333333,-2|11|0x333333,3|14|0x333333,-1|31|0x333333,5|21|0x333333,8|13|0x333333,23|1|0x333333,29|32|0x333333,7|32|0x333333", 100, 0, 0, 1079, 1919, 0, 0)
	x2, y2 = findMultiColorInRegionFuzzy(0x333333,"31|1|0x333333,12|-4|0x333333,8|8|0x333333,0|15|0x333333,7|28|0x333333,19|27|0x333333,26|27|0x333333,25|21|0x333333", 100, 0, 0, 1079, 1919, 0, 0)
	if x1 > -1 and x2 >-1 then
		return true
	end
	--	keepScreen(false)
end

--通过多点找色函数找到好友排行榜榜首的“🏅”标志
function findGoldMedal()
	--	keepScreen(true)
	x, y = findMultiColorInRegionFuzzy(0xffe159,"9|-8|0xefae44,-7|-10|0xefae44,-15|-16|0xffe159,16|-15|0xffe159,-1|-44|0xefae44", 100, 0, 0, 1079, 1919, 0, 0)
	if x > -1 then
		return true
	end
	--	keepScreen(false)
end

function timer()
	t=getNetTime()
	return t
end

--设置当前脚本开发环境的屏幕分辩率，使脚本适配不同分辩率的设备;本脚本在1080*1920分辨率环境下开发
function ratioInit()
	--w,h = getScreenSize()
	setScreenScale(1080,1920)
end

function main()
	while true do
		enterAntForestPage()--进入蚂蚁森林主页
		
		-- 这里不能用循环次数来判定，否则每次进入循环都会因为不满足条件而退出循环，达不到强制收集能量的目的
		t1 = timer()
		while (not findTreeLeaf() ) do
			findTreeLeaf()
			while ( (timer()-t1) > 10 ) do
				if ( (timer()-t1) >20 ) then
					break
				end
				collect()
			end
		end
		
		collect()--收集自己主页的能量
		
		enterRank()--进入好友排行榜
		
		enterOthers()--在好友排行榜页面检测是否有能量可收取，有的话就点击进去收取能量
		
		pressKey('BACK',false)--翻页到好友排行榜页面末尾时，点击返回，回到蚂蚁森林首页
		
		mSleep(1000)--延时1000毫秒（即1秒）
		
		pressKey('BACK',false)--再点击返回，回到支付宝首页
		
		mSleep(5000)--延时5000毫秒（即5秒）
		
	end
end

init("com.eg.android.AlipayGphone", 0); --以应用 "com.eg.android.AlipayGphone" 竖屏初始化
init("0", 0); --目标程序的应用ID，当填写"0"时，自动使用当前运行的应用; 屏幕方向，0 - 竖屏， 1 - Home键在右边， 2 - Home键在左边
ratioInit()
main()
