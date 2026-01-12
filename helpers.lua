-- local lgi   = require('lgi')
-- local cairo = lgi.cairo
-- local gdk   = lgi.Gdk

local _H = {}

-- I feel like YanDev saying "I wish there was a better way to do this"...
-- Gets the suffix for any given day of the month.
function _H.get_suffix(day)
   if day > 3 and day < 21 then
      return 'th'
   end

   if day % 10 == 1 then
      return 'st'
   elseif day % 10 == 2 then
      return 'nd'
   elseif day % 10 == 3 then
      return 'rd'
   else
      return 'th'
   end
end

-- Returns true when `e` is an entry in `table`.
function _H.in_table(e, table)
   for _, v in table do
      if v == e then
         return true
      end
   end
   return false
end

function _H.exists(path)
   if path == nil or type(path) ~= 'string' then
      return false
   end

   return os.rename(path, path)
end

-- Check whether a file exists.
function _H.file_exists(path)
   if not _H.exists(path) then return false end

   local file = io.open(path)
   if file then
      io.close(file)
      return true
   end

   return false
end

-- Check whether a directory exists.
function _H.dir_exists(path)
   if path == nil or type(path) ~= 'string' then
      return false
   end

   if path:sub(-1, -1) ~= '/' then
      path = path .. '/'
   end
   return (_H.exists(path) and not _H.file_exists(path))
end

-- function _H.downscale(path, w, h)
--    if not _H.file_exists(path) then return end
--    local target_r = w / h
--
--    -- Create a surface for the image.
--    local image = gdk.Pixbuf.new_from_file(path)
--    local source = {}
--    source.surf = cairo.ImageSurface.create(cairo.Format.ARGB32, image.width, image.height)
--    source.cr   = cairo.Context(source.surf)
--    gdk.cairo_set_source_pixbuf(source.cr, image, 0, 0)
--    source.cr:paint()
--
--    local src_w = source.surf:get_width()
--    local src_h = source.surf:get_height()
--    local src_r = src_w / src_h
--
--    local crop = {}
--    --- If there is a ratio mismatch, we need to crop.
--    if src_r ~= target_r then
--       local new_w, new_h
--       if src_r >= 1 then
--          -- Wide image.
--          new_h = src_h
--          new_w = src_h * target_r
--          crop.x = (src_w - new_w) / 2
--          crop.y = 0
--       else
--          -- Tall image.
--          new_h = math.floor(src_w / target_r)
--          new_w = src_w
--          crop.x = 0
--          crop.y = (src_h - new_h) / 2
--       end
--       crop.surf = cairo.ImageSurface.create(cairo.Format.ARGB32, new_w, new_h)
--    else
--       crop.x = 0
--       crop.y = 0
--       crop.surf = cairo.ImageSurface.create(cairo.Format.ARGB32, image.width, image.height)
--    end
--    crop.cr = cairo.Context(crop.surf)
--    crop.cr:set_source_surface(source.surf, -crop.x, -crop.y)
--    crop.cr:paint()
--
--    --- If the image is already <= to the target, just return the surface.
--    if src_w <= w and src_h <= h then
--       source.cr:destroy()
--       source.surf:destroy()
--       return crop.surf
--    end
--
--    -- Downscale.
--    local scaled = {}
--    scaled.surf = cairo.ImageSurface.create(cairo.Format.ARGB32, w, h)
--    scaled.cr   = cairo.Context(scaled.surf)
--
--    scaled.cr:scale(w / crop.surf:get_width(), h / crop.surf:get_height())
--    scaled.cr:set_source_surface(crop.surf, 0, 0);
--    scaled.cr:paint()
--
--    -- Free the original image.
--    source.cr:destroy()
--    source.surf:destroy()
--    -- And the crop.
--    crop.cr:destroy()
--    crop.surf:destroy()
--
--    return scaled
-- end

return _H
