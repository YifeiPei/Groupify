class CreateStudentUsers < ActiveRecord::Migration
  def change
    create_table :student_users do |t|
      t.string :student_id
      t.string :username
      t.string :email
      t.string :password
      t.string :salt
      t.datetime :created_at
      t.datetime :updated_at
      t.string :university
      t.string :gender
      t.string :degree
      t.string :MBTI
      t.string :FelderSolomonLearningType

      t.timestamps
    end
  end
end
