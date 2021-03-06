module WindowManager
  def on_new_window(&block)
    @browser.windows.last.use do
      yield block
    end
  end

  def close_all_windows(browser)
    window = nil
    begin
      browser.windows.size.downto(1) do |idx|
        window = idx
        browser.windows[idx - 1].close unless idx==1
        browser.close if idx==1
      end
    rescue Exception => e
      warn "Error deleting window # #{window}"
      warn e.message.to_s
    end
  end

  def close_all_windows_except_main(browser)
    window = nil
    begin
      browser.windows.size.downto(2) do |idx|
        window = idx
        browser.windows[idx - 1].close unless idx==1
      end
    rescue Exception => e
      warn "Error deleting window # #{window}"
      warn e.message.to_s
    end
  end
end