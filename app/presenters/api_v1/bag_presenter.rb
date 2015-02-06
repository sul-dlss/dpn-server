
module ApiV1
  class BagPresenter
    def initialize(bag)
      @bag = bag
    end

    def to_hash
      hash = {
        :uuid => @bag.uuid,
        :local_id => @bag.local_id,
        :size => @bag.size,
        :first_version_uuid => @bag.first_version.uuid,
        :version => @bag.version,
        :original_node => @bag.original_node.namespace,
        :admin_node => @bag.admin_node.namespace,
        :repl_nodes => @bag.replicating_nodes.pluck(:namespace),
        :fixities => @bag.fixity_checks.collect do |check|
          {
            :alg => check.fixity_alg.name,
            :value => check.value
          }
        end,
        :created_at => @bag.created_at,
        :updated_at => @bag.updated_at

      }

      case @bag.class
      when "DataBag"
        hash[:type] = "data"
        hash[:rights] = @bag.rights_bags.pluck(:uuid)
        hash[:brightening] = bag.brightening_bags.pluck(:uuid)
      when "RightsBag"
        hash[:type] = "rights"
        hash[:rights] = nil
        hash[:brightening] = nil
      when "BrighteningBag"
        hash[:type] = "brightening"
        hash[:rights] = nil
        hash[:brightening] = nil
      else
        throw TypeError, "illegal bag type #{@bag.class}"
      end

      return hash
    end

    def to_json
      return self.to_hash.to_json
    end

    private
    attr_reader :bag
  end
end
