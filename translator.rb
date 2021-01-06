require "shoes"
require "socket"

#<$> xTranslator Created By Special_Esmit
#"<^> Start :("

$ipx = "localhost"
$portx = 15001

def trans(te,mode)
	begin
		if te.empty? == false
			$tx = te
			sx = TCPSocket.open($ipx,$portx)
			sx.write($tx)
			rx = sx.gets
			sx.close
			if rx == "<!> Connection Or Translating Error, Connection Closed"
				return "<!> Connecting Or Translating Error And Closing With Server"
			end
			if mode == "Saver_Mode"
				fx = File.new("Savetr.txt",'a') ; fx.write("Translated: " + rx + "\n") ; fx.close 
				return  "<^> Translated : " + rx.to_s
			else
				return  "<^> Translated : " + rx.to_s
			end
		end
	rescue
		return "<!> Error !"
	end
end

Shoes.app :title => "Translator" , :height => 240, :width => 200 do
	$lan = ""
	$mode = ""
	flow do
		md = list_box :items => ["Normal", "Saver_Mode"]
		para "\n"
		r = radio :films
		para "English\n"
		r2 = radio :films
		para "Persian\n"
		button "Submit" do
			if md.text == "Saver_Mode"
				$mode = "Saver_Mode"
			else
				$mode = "Noramal"
			end
			if r2.checked? == true
				$lan = ("fa")
			else
				$lan = ("en")
			end
		end
	end
	keypress do |k|
		if k.inspect.to_s == ":control_m"
				$tes = edit_box :width => 80, :height => 40
				button "Translate" do
					spin = spinner width: 80, start: true
					vd = $lan + "^" + $tes.text
					tr = trans(vd.to_s,$mode)
					alert tr
					spin.stop
				end
		end
	end
end
