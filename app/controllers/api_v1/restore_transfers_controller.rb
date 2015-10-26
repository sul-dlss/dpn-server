# Copyright (c) 2015 The Regents of the University of Michigan.
# All Rights Reserved.
# Licensed according to the terms of the Revised BSD License
# See LICENSE.md for details.



class ApiV1::RestoreTransfersController < ApplicationController
  include Authenticate
  include Adaptation
  include Pagination

  local_node_only :create, :destroy
  uses_pagination :index
  adapt!

  def index
    ordering = {updated_at: :desc}
    if params[:order_by]
      new_ordering = {}
      params[:order_by].split(',').each do |order_column|
        if [:created_at, :updated_at].include?(order_column.to_sym)
          new_ordering[order_column.to_sym] = :desc
        end
      end
      ordering = new_ordering unless new_ordering.empty?
    end
    @restore_transfers = RestoreTransfer.updated_after(params[:after])
      .with_bag_id(params[:bag_id])
      .with_status(params[:status])
      .with_to_node_id(params[:to_node_id])
      .with_from_node_id(params[:from_node_id])
      .order(ordering)
      .page(@page)
      .per(@page_size)

    render "shared/index", status: 200
  end


  def show
    @restore_transfer = RestoreTransfer.find_by_restore_id!(params[:restore_id])
    render "shared/show", status: 200
  end


  def create
    if RestoreTransfer.where(restore_id: params[:restore_id]).exists?
      render nothing: true, status: 409 and return
    else
      @restore_transfer = RestoreTransfer.new(create_params)
      if @restore_transfer.save
        render "shared/create", status: 201
      else
        render "shared/errors", status: 400
      end
    end
  end


  def update
    @restore_transfer = RestoreTransfer.find_by_restore_id!(params[:restore_id])

    if @requester != @restore_transfer.from_node && @requester.namespace != Rails.configuration.local_namespace
      render nothing: true, status: 403 and return
    end

    if params[:updated_at] > @restore_transfer.updated_at
      @restore_transfer.attributes = update_params
      @restore_transfer.requester = @requester
      if ChangeValidator.new.is_valid?(@restore_transfer)
        unless @restore_transfer.save
          render "shared/errors", status: 400 and return
        end
      end
    end

    render "shared/update", status: 200
  end


  def destroy
    restore_transfer = RestoreTransfer.find_by_restore_id!(params[:restore_id])
    restore_transfer.destroy!
    render nothing: true, status: 204
  end

  private
  def create_params
    params.permit(RestoreTransfer.attribute_names)
  end

  def update_params
    params.permit(RestoreTransfer.attribute_names + [:requester])
  end

end
