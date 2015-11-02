class Employee
  attr_accessor :boss, :salary
  def initialize name, title, salary, boss = nil
    @name, @title, @salary, @boss = name, title, salary, boss
  end

  def bonus multiplier
    @salary * multiplier
  end

  def employees
    []
  end
end

class Manager < Employee
  attr_accessor :employees
  def initialize name, title, salary, boss = nil
    super name, title, salary, boss
    @employees = []
  end

  def bonus multiplier
    bonus = 0
    queue = @employees
    until queue.empty?
      employee = queue.shift
      bonus += employee.salary * multiplier
      queue += employee.employees
    end
    bonus
  end

  def add_employee(employee)
    @employees << employee
    employee.boss = self
  end

end



ned = Manager.new("Ned", :founder, 1_000_000)
darren = Manager.new("Darren", :TA_Manager, 78_000, ned)
shawna = Employee.new("Shawna", :TA, 12_000, darren)
david = Employee.new("David", :TA, 10_000, darren)

ned.add_employee(darren)
darren.add_employee(shawna)
darren.add_employee(david)

puts ned.bonus(5)
puts darren.bonus(4)
puts david.bonus(3)
