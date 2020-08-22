_cmd_exists() {
    command -v "${1}" 2>&1 > /dev/null
}

_suffix_mv() {
    SRC_PATH="${1}"
    DEST_DIR="${2}"
    SRC_BASENAME="$( basename -- "${SRC_PATH}" )"

    if [ ! -e "${DEST_DIR}/${SRC_BASENAME}" ]; then
        DEST_PATH="${DEST_DIR}/${SRC_BASENAME}"
    else
        SUFFIX=1
        while [ -e "${DEST_DIR}/${SRC_BASENAME}_${SUFFIX}" ]; do
            SUFFIX=$(( ${SUFFIX} + 1 ))
        done
        DEST_PATH="${DEST_DIR}/${SRC_BASENAME}_${SUFFIX}"
    fi

    echo "Moving ${SRC_PATH} to ${DEST_PATH}"
    mv -- "${SRC_PATH}" "${DEST_PATH}"
}
