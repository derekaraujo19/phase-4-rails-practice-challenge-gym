class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :total_membership_amount



  def total_membership_amount
    sum = 0
    self.object.memberships.each do |membership|
      sum += membership.charge
    end
    return sum
  end



end
