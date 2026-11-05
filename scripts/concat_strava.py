import argparse
import os

from typing import List
from xml.etree import ElementTree
from xml.etree.ElementTree import Element


def find(node: Element, key=None, reverse=False):
    s = [node]
    while s != []:
        u = s.pop()
        if key(u):
            return u
        vs = list(u)
        if reverse:
            vs = vs[::-1]
        s += list(vs)  # append children


def findall(node: Element, key=None, reverse=False):
    s = [node]
    while s != []:
        u = s.pop()
        if key(u):
            yield u
        vs = list(u)
        if reverse:
            vs = vs[::-1]
        s += list(vs)  # append children


def extract_namespaces(xml_path: str):
    return dict([
        node for _, node in ElementTree.iterparse(
            xml_path, events=['start-ns']
        )
    ])


def get_creation_time(root: Element) -> str:
    metadata = find(root, key=lambda x: x.tag.endswith("metadata"))
    assert metadata is not None, "Could not find metadata"
    time = find(metadata, key=lambda x: x.tag.endswith("time"))
    if time is not None:
        return time.text


def concat_gpxs(gpx_paths: List[str], output_path: str) -> ElementTree:
    # register namespaces
    namespaces = extract_namespaces(gpx_paths[0])
    for prefix, uri in namespaces.items():
        ElementTree.register_namespace(prefix, uri)

    # sort data by creation time
    gpx_roots = []
    for gpx_path in gpx_paths:
        tree = ElementTree.parse(gpx_path)
        root = tree.getroot()
        creation_time = get_creation_time(root)
        gpx_roots.append((creation_time, tree, root))
    gpx_roots.sort()

    # get earliest tracking element
    trk = find(gpx_roots[0][2], key=lambda x: x.tag.endswith("trk"))
    assert trk is not None, "Could not find tracking in first gpx"

    # concat all future trackings
    insert_pos = len(list(trk))
    for _, _, gpx_root in gpx_roots[1:]:
        print(insert_pos)
        trk_segs = findall(gpx_root, key=lambda x: x.tag.endswith("trkseg"))
        for trk_seg in trk_segs:
            trk.insert(insert_pos, trk_seg)
            insert_pos += 1

    # save
    gpx_roots[0][1].write(output_path)
    print(f"Output: {output_path}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--gpx",
        nargs="+",
        required=True,
        help="Path to gpx files to combine",
    )
    parser.add_argument(
        "--output",
        nargs="+",
        default=os.path.expanduser("~/Downloads/output.gpx"),
        help="Path to output",
    )
    args = parser.parse_args()
    print(args)
    concat_gpxs(args.gpx, args.output)
