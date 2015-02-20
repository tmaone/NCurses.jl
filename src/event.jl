module event

const _NC_EVENT_TIMEOUT_MSEC = 1
const _NC_EVENT_FILE = 2
const _NC_EVENT_FILE_READABLE = 2
#  Not supported yet... *
const _NC_EVENT_FILE_WRITABLE = 4
const _NC_EVENT_FILE_EXCEPTION = 8

immutable _nc_event
  _type::Cint
  type data
    timeout_msec::Clong
    type fev
        flags::Cuint
        fd::Cint
        result::Cuint
    end
  end
end

immutable _nc_eventlist
  count::Cint
  result_flags::Cint
  events::Ptr{Array{_nc_event, 1}}
end

end
