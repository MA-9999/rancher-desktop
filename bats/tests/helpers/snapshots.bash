get_snapshot_id_from_name() {
    local name=$1
    run rdctl snapshot list --json
    assert_success
    run jq_output 'select(.name == "'"$name"'") | .id'
    assert_success
    echo "$output"
}

delete_all_snapshots() {
    run rdctl snapshot list --json
    assert_success
    for x in $(jq_output '.id'); do
        run rdctl snapshot delete "$x"
        assert_nothing
    done
}
