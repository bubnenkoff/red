Red [
	Title:   "Redbin codec"
	Author:  "Vladimir Vasilyev"
	File:	 %redbin.red
	Tabs:	 4
	Rights:  "Copyright (C) 2020 Red Foundation. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

put system/codecs 'redbin context [
	title: "Redbin codec"
	name:  'Redbin
	mime-type: []
	suffixes:  [%.redbin]
	
	encode: routine [data [any-type!] where [any-type!]][
		stack/set-last as red-value! redbin/encode data
	]
	
	decode: routine [payload [binary!] /local blk [red-block!]][
		if 16 >= binary/rs-length? payload [fire [TO_ERROR(script invalid-data) payload]]
		blk: block/push-only* 0
		redbin/decode binary/rs-head payload blk yes
		if (block/rs-length? blk) = 1 [blk: as red-block! block/rs-head blk]
		SET_RETURN(blk)
	]
]
