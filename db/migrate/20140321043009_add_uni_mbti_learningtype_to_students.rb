class AddUniMbtiLearningtypeToStudents < ActiveRecord::Migration
  def change
    add_column :students, :MBTI, :string
    add_column :students, :LearningType, :string
  end
end
