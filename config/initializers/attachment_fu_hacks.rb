require 'technoweenie/attachment_fu'

module Technoweenie
  module AttachmentFu
    def save_attachment?
      if temp_path
        return File.file?(temp_path.to_s)
      else
        return false
      end
    end

   def temp_path
     return nil if temp_paths.empty?
     p = temp_paths.first
     p.respond_to?(:path) ? p.path : p.to_s
   end
   
    def temp_paths
      @temp_paths ||= (new_record? || filename.blank? || !File.exist?(full_filename)) ? [] : [copy_to_temp_file(full_filename)]
    end
  end
end