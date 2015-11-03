class Parent
	CONST_PARENT = "jeff"

	def check_constant
		puts self.class::CONST_CHILD
	end

end

class Child < Parent
	CONST_CHILD = CONST_PARENT + "!!!!"
end

class Child1 < Parent
	CONST_CHILD = CONST_PARENT + "????"
end
