#include <md4c-html.h>
#include <stdlib.h>
#include <string.h>
#include <xmi.h>

struct membuffer {
    char* data;
    size_t asize;
    size_t size;
};

static int membuf_init(struct membuffer* buf, MD_SIZE new_asize) {
    buf->size = 0;
    buf->asize = new_asize;
    buf->data = malloc(buf->asize);
    if (buf->data == NULL) {
        return -1;
    }
    return 0;
}

static void membuf_exit(struct membuffer* buf) {
    if (buf->data) {
        free(buf->data);
    }
}

static int membuf_grow(struct membuffer* buf, size_t new_asize) {
    buf->data = realloc(buf->data, new_asize);
    if (buf->data == NULL) {
        return -1;
    }
    buf->asize = new_asize;
    return 0;
}

static void membuf_append(struct membuffer* buf, const char* data, MD_SIZE size) {
    if (buf->asize < buf->size + size) {
        membuf_grow(buf, buf->size + buf->size / 2 + size);
    }
    memcpy(buf->data + buf->size, data, size);
    buf->size += size;
}

static void process_output(const MD_CHAR* text, MD_SIZE size, void* userdata) {
    membuf_append((struct membuffer*)userdata, text, size);
}

static int md2html(lua_State* lua) {
    size_t mdlen = 0;
    const char* mdstr = luaL_checklstring(lua, 1, &mdlen);

    struct membuffer buf_out = {0};
    if (membuf_init(&buf_out, (MD_SIZE)(mdlen + mdlen / 8 + 64)) < 0) {
        lua_pushnil(lua);
        lua_pushliteral(lua, "could not allocate output buffer!");
        return 2;
    }

    int p_flags = MD_FLAG_TABLES | MD_FLAG_STRIKETHROUGH | MD_FLAG_TASKLISTS | MD_FLAG_UNDERLINE | MD_FLAG_NOHTMLBLOCKS | MD_DIALECT_COMMONMARK | MD_DIALECT_GITHUB;
    int r_flags = 0;
    int ret = md_html(mdstr, (MD_SIZE)mdlen, process_output, (void*)&buf_out, p_flags, r_flags);
    if (ret != 0) {
        lua_pushnil(lua);
        lua_pushliteral(lua, "could not convert markdown to html!");
        membuf_exit(&buf_out);
        return 2;
    }

    lua_pushlstring(lua, buf_out.data, buf_out.size);
    membuf_exit(&buf_out);
    return 1;
}

int luaopen(md4c, lua_State* lua) {
    static const luaL_Reg funcs[] = {
        {"md2html", md2html},
        {NULL, NULL}
    };
    lua_newtable(lua);
    luaL_setfuncs(lua, funcs, 0);
    return 1;
}
