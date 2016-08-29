# Copyright (c) 2015 The Regents of the University of Michigan.
# All Rights Reserved.
# Licensed according to the terms of the Revised BSD License
# See LICENSE.md for details.

class ChangeFixityChecksToDigests < ActiveRecord::Migration
  def change
    add_reference :fixity_checks, :node, index: true, foreign_key: true
    rename_table :fixity_checks, :message_digests
  end
end
