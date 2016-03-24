class Url < ActiveRecord::Base
	validates :long, :presence => true
	validates :long, :uniqueness => true

	after_create :format, :shorten

	def format
		unless /https?:\/\/\S+/ =~ self.long
			self.long = "http://" + self.long
		end
	end

	def shorten
		base64 = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "_"]
		shortend_url = base64.sample(7).join
		while self.success == false
			preexisting_url = Url.where(short: shortend_url)
			if preexisting_url[0] != nil
				shortend_url = base64.sample(7).join
			else
				self.success = true
			end
		end
		self.short = shortend_url
		self.save
	end
end
