module ActiveScaffold
  module Helpers
    module Pagination
      
      def active_scaffold_pager_id
        active_scaffold_id + "_pager"
      end
      
      def options_for_ajax_pagination_link(params)
        url_options = params.dup
        url_options.delete(:page)
        
        { :url => url_options,
            :after => "$('#{loading_indicator_id(:action => :pagination)}').style.visibility = 'visible';",
            :complete => "$('#{loading_indicator_id(:action => :pagination)}').style.visibility = 'hidden';",
            :update => active_scaffold_content_id,
            :failure => "ActiveScaffold.report_500_response('#{active_scaffold_id}')",
            :method => :get }
#        { :href => url_for(params.merge(:page => page_number)) }
        
      end
      
      def pagination_ajax_links(current_page, params)
        start_number = 1
        end_number = current_page.pager.last.number
        
        text_field_tag(active_scaffold_pager_id, 
          current_page.number,
          :class => current_page.number < 100 ? "tiny" : "small",
          :onchange => remote_function(options_for_ajax_pagination_link(params).merge(:with => "'page=' + $F(this)"))
        ) + " of #{end_number}"
      end
    end
  end
end