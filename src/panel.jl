# #===== PANEL library ====#
#
# function update_panels()
#     ccall((:update_panels, npanel), Void, () )
# end
#
# function doupdate()
#     ccall((:doupdate, npanel ), Void, () )
# end
#
# function new_panel( win::Ptr{Void} )
#     ccall((:new_panel, npanel ), Ptr{Void}, ( Ptr{Void}, ), win )
# end
#
# function top_panel( pan::Ptr{Void} )
#     ccall((:top_panel, npanel ), Int, ( Ptr{Void}, ), pan )
# end
#
# function bottom_panel( pan::Ptr{Void} )
#     ccall((:bottom_panel, npanel ), Int, ( Ptr{Void}, ), pan )
# end
#
# function move_panel( pan::Ptr{Void}, starty::Int, startx::Int )
#     ccall((:move_panel, npanel ), Ptr{Void}, ( Ptr{Void}, Int, Int ), pan, starty, startx )
# end
#
# function del_panel( panel::Ptr{Void} )
#     ccall((:del_panel, npanel ), Void, (Ptr{Void}, ), panel )
# end
#
# function show_panel( panel::Ptr{Void} )
#     ccall((:show_panel, npanel ), Int, (Ptr{Void}, ), panel )
# end
#
# function hide_panel( panel::Ptr{Void} )
#     ccall((:hide_panel ), Int, (Ptr{Void}, ), panel )
# end
#
# function panel_hidden( panel::Ptr{Void } )
#     ccall((:panel_hidden, npanel ), Int, (Ptr{Void}, ), panel ) != 0
# end
#
# function replace_panel( panel::Ptr{Void}, window::Ptr{Void} )
#     ccall((:replace_panel ), Void, (Ptr{Void}, Ptr{Void} ), panel, window )
# end
#
# function set_panel_userptr( p1::Ptr{Void}, p2::Ptr{Void} )
#     ccall((:set_panel_userptr), Void, (Ptr{Void}, Ptr{Void}), p1, p2 )
# end
#
# function wborder( win::Ptr{Void},ls::chtype,rs::chtype,ts::chtype,bs::chtype,tl::chtype,tr::chtype,bl::chtype,br::chtype)
#     ccall((:wborder, npanel), Int, (Ptr{Void}, Uint8, Uint8, Uint8, Uint8, Uint8, Uint8, Uint8, Uint8), ls, rs,ts, bs, tl, tr, bl, br)
# end
#
# export update_panels, doupdate, new_panel, top_panel, bottom_panel, hide_panel, move_panel, del_panel, show_panel, panel_hidden, replace_panel, set_panel_userptr, wborder
#
#
# # # typedef struct panel
# # # {
# # #   WINDOW *win;#===== PANEL library ====#
# #
# # function update_panels()
# #     ccall((:update_panels, npanel), Void, () )
# # end
# #
# # function doupdate()
# #     ccall((:doupdate, npanel ), Void, () )
# # end
# #
# # function new_panel( win::Ptr{Void} )
# #     ccall((:new_panel, npanel ), Ptr{Void}, ( Ptr{Void}, ), win )
# # end
# #
# # function top_panel( pan::Ptr{Void} )
# #     ccall((:top_panel, npanel ), Int, ( Ptr{Void}, ), pan )
# # end
# #
# # function bottom_panel( pan::Ptr{Void} )
# #     ccall((:bottom_panel, npanel ), Int, ( Ptr{Void}, ), pan )
# # end
# #
# # function move_panel( pan::Ptr{Void}, starty::Int, startx::Int )
# #     ccall((:move_panel, npanel ), Ptr{Void}, ( Ptr{Void}, Int, Int ), pan, starty, startx )
# # end
# #
# # function del_panel( panel::Ptr{Void} )
# #     ccall((:del_panel, npanel ), Void, (Ptr{Void}, ), panel )
# # end
# #
# # function show_panel( panel::Ptr{Void} )
# #     ccall((:show_panel, npanel ), Int, (Ptr{Void}, ), panel )
# # end
# #
# # function hide_panel( panel::Ptr{Void} )
# #     ccall((:hide_panel ), Int, (Ptr{Void}, ), panel )
# # end
# #
# # function panel_hidden( panel::Ptr{Void } )
# #     ccall((:panel_hidden, npanel ), Int, (Ptr{Void}, ), panel ) != 0
# # end
# #
# # function replace_panel( panel::Ptr{Void}, window::Ptr{Void} )
# #     ccall((:replace_panel ), Void, (Ptr{Void}, Ptr{Void} ), panel, window )
# # end
# #
# # function set_panel_userptr( p1::Ptr{Void}, p2::Ptr{Void} )
# #     ccall((:set_panel_userptr), Void, (Ptr{Void}, Ptr{Void}), p1, p2 )
# # end
# #
# # function wborder( win::Ptr{Void},ls::chtype,rs::chtype,ts::chtype,bs::chtype,tl::chtype,tr::chtype,bl::chtype,br::chtype)
# #     ccall((:wborder, npanel), Int, (Ptr{Void}, Uint8, Uint8, Uint8, Uint8, Uint8, Uint8, Uint8, Uint8), ls, rs,ts, bs, tl, tr, bl, br)
# # end
# #
# # export update_panels, doupdate, new_panel, top_panel, bottom_panel, hide_panel, move_panel, del_panel, show_panel, panel_hidden, replace_panel, set_panel_userptr, wborder
# # #   struct panel *below;
# # #   struct panel *above;
# # #   NCURSES_CONST void *user;
# # # } PANEL;
# # #
# # # #if	defined(__cplusplus)
# # # extern "C" {
# # # #endif
# # #
# # # extern NCURSES_EXPORT(WINDOW*) panel_window (const PANEL *);
# # # extern NCURSES_EXPORT(void)    update_panels (void);
# # # extern NCURSES_EXPORT(int)     hide_panel (PANEL *);
# # # extern NCURSES_EXPORT(int)     show_panel (PANEL *);
# # # extern NCURSES_EXPORT(int)     del_panel (PANEL *);
# # # extern NCURSES_EXPORT(int)     top_panel (PANEL *);
# # # extern NCURSES_EXPORT(int)     bottom_panel (PANEL *);
# # # extern NCURSES_EXPORT(PANEL*)  new_panel (WINDOW *);
# # # extern NCURSES_EXPORT(PANEL*)  panel_above (const PANEL *);
# # # extern NCURSES_EXPORT(PANEL*)  panel_below (const PANEL *);
# # # extern NCURSES_EXPORT(int)     set_panel_userptr (PANEL *, NCURSES_CONST void *);
# # # extern NCURSES_EXPORT(NCURSES_CONST void*) panel_userptr (const PANEL *);
# # # extern NCURSES_EXPORT(int)     move_panel (PANEL *, int, int);
# # # extern NCURSES_EXPORT(int)     replace_panel (PANEL *,WINDOW *);
# # # extern NCURSES_EXPORT(int)     panel_hidden (const PANEL *);
# # #
# # # #if NCURSES_SP_FUNCS
# # # extern NCURSES_EXPORT(PANEL *) ground_panel(SCREEN *);
# # # extern NCURSES_EXPORT(PANEL *) ceiling_panel(SCREEN *);
# # #
# # # extern NCURSES_EXPORT(void)    NCURSES_SP_NAME(update_panels) (SCREEN*);
# # # #endif
# # #
# # # #if	defined(__cplusplus)
# # # }
# # # #endif
