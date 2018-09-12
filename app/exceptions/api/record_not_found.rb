module Api
 class RecordNotFound < StandardError
   def code
     'RECORD_NOT_FOUND'
   end

   def public_message
     Settings.api.errors.record_not_found
   end
 end
end
