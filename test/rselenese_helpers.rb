module SeleniumOnRails
  module TestBuilderActions
    
    def watch_ajax_requests
      command "watchAjaxRequests"
    end
  
    def wait_for_ajax_request(seconds)
      command "waitForAjaxRequest", seconds
    end
    
    def click_and_wait_ajax(link, seconds=1000)
      watch_ajax_requests
      click link
      wait_for_ajax_request seconds
      pause 100
    end
    
    def wait_for_and_click_and_wait_ajax(link)
      wait_for_element_present(link)
      click_and_wait_ajax link
    end
    def wait_for_and_click(link)
      wait_for_element_present(link)
      click link
    end
  end
end
