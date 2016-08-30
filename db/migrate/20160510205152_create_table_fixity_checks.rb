# Copyright (c) 2015 The Regents of the University of Michigan.
# All Rights Reserved.
# Licensed according to the terms of the Revised BSD License
# See LICENSE.md for details.

class CreateTableFixityChecks < ActiveRecord::Migration
  def change
    create_table(:fixity_checks, primary_key: :fixity_check_id) do |t|
      t.boolean :success, null: false
      t.datetime :fixity_at, null: false
      t.datetime :created_at, null: false
    end

    add_reference :fixity_checks, :bag, index: true, foreign_key: true
    add_reference :fixity_checks, :node, index: true, foreign_key: true
  end
end
